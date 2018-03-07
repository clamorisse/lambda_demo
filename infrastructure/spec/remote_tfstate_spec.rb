require 'spec_helper'

describe s3_bucket('tfstate_lambda') do
  it { should exist }
  it { should have_object('lambda_s3_triggered/dev/terraform.tfstate') }
end
