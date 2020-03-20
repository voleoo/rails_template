# frozen_string_literal: true

require 'spec_helper'

RSpec.describe UserJob do
  it 'should return' do
    user = create(:user)
    job = UserJob.perform_later(user.id)
    expect(job.job_id).to be_present
    expect(user.reload.sign_in_count).to eq(1)
  end
end
