require 'spec_helper'

describe s3_bucket('tfstate_lambda_clarivate') do
  it { should exist }
end
