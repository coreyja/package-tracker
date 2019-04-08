# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Easypost Events' do
  let(:header) { { 'CONTENT_TYPE' => 'application/json' } }
  let(:json) { FakeEasyPost.event_details_json }

  it 'creates a DJ to process the event containing the full json from the event' do
    expect { post api_easypost_events_path, params: json, headers: headers }
      .to change { Delayed::Job.count }.from(0).to(1) &
          change { Delayed::Job.where('handler ilike ?', '%EasypostEventPerformer%').count }.from(0).to(1)
    expect(response.status).to eq 204
    expect(Delayed::Job.last.payload_object.post_body).to eq json
  end
end
