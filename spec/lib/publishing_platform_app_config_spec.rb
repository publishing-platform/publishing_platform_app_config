# frozen_string_literal: true

RSpec.describe PublishingPlatformAppConfig do
  it "has a version number" do
    expect(PublishingPlatformAppConfig::VERSION).not_to be nil
  end
end
