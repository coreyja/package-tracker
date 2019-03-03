# frozen_string_literal: true

require 'rails_helper'

RSpec.describe EasypostEventPerformer do
  subject { described_class.new raw_json }

  describe '#perform' do
    context 'when the event result is a tracker object' do
      let(:raw_json) { FakeEasyPost.event_details_json }

      context 'when there should NOT be updates' do
        it 'does NOT send a push notification' do
          value = true
          expect(value).to eq false
        end
      end

      context 'when there should be updates' do
        it 'does send a push notification' do
          value = true
          expect(value).to eq false
        end
      end
    end
  end
end
