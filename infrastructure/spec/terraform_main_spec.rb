
require 'spec_helper'

describe iam_role('lambda_s3_triggered-lambda-exec_role') do
  it { should exist }
end

describe s3_bucket('source_bvc_filesanalyzed') do
  it { should exist }
#  it { should have_object('lambda_s3_triggered/dev/terraform.tfstate') }
end

describe s3_bucket('source_bvc_files') do
  it { should exist }
#  it { should have_object('lambda_s3_triggered/dev/terraform.tfstate') }
end
