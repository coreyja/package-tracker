# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EasypostEventPerformer do
  subject { described_class.new raw_json }

  describe '#perform' do
    context 'when the event result is a tracker object' do
      let(:raw_json) { FakeEasyPost.event_details_json }
      let!(:package) do
        FactoryBot.create(
          :package,
          tracking_number: '9400110898825022579493',
          carrier: 'USPS',
          status: 'unknown',
          easypost_tracking_id: 'trk_c8e0edb5bb284caa934a0d3db23a148z'
        )
      end

      it 'updates the associated package object and sends a push notification' do
        expect { subject.perform }
          .to change { package.reload.status }.from('unknown').to('in_transit')
          .and change { package.reload.tracking_updates.count }.from(0).to(2)
          .and enqueue_job(PackageUpdatePushNotificationJob).with(package).exactly(:once)
        expect(package.tracking_updates.pluck(:status)).to match_array %w[pre_transit in_transit]
      end

      context 'when no package with the given id exists' do
        let!(:package) { FactoryBot.create(:package, easypost_tracking_id: 'other_tracking_number') }

        it 'errors' do
          expect { subject.perform }.to raise_error ActiveRecord::RecordNotFound
        end
      end

      context 'when there should NOT be updates' do
        before do
          FakeEasyPost.tracking_details_enabled = false
        end

        it 'does NOT send a push notification' do
          expect { subject.perform }.not_to enqueue_job(PackageUpdatePushNotificationJob)
        end
      end
    end
  end
end
