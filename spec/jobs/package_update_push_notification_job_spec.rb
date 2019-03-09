# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PackageUpdatePushNotificationJob do
  describe '#perform' do
    let(:user) { FactoryBot.create(:user) }
    let(:package) { FactoryBot.create(:package, user: user) }

    before do
      allow(Webpush).to receive(:payload_send)
    end

    context 'when the owner of the Package has no push notification registrations' do
      it 'noops' do
        subject.perform package
        expect(Webpush).not_to have_received(:payload_send)
      end
    end

    context 'when there are push notification registrations' do
      let!(:push_notification_registrations) { FactoryBot.create_list(:push_notification_registration, 3, user: user) }

      it 'sends one push notification per registration' do
        subject.perform package
        expect(Webpush).to have_received(:payload_send).exactly(3).times
        push_notification_registrations.each do |reg|
          expect(Webpush).to have_received(:payload_send).with(hash_including(p256dh: reg.p256dh, auth: reg.auth)).once
        end
      end
    end
  end
end
