
require 'spec_helper'

describe iam_role('lambda_s3_triggered-lambda-exec_role') do
  it { should exist }
end

describe s3_bucket('source_bvc_filesanalyzed') do
  it { should exist }
  it { should have_object('data/CA4PExc1500.csv') }
end

describe s3_bucket('source_bvc_files') do
  it { should exist }
  it { should have_object('data/CA4PExc1500.csv') }
end

describe lambda('lambda_s3_triggered-function') do
  it { should exist }
  its (:role) { is_expected.to eq('lambda_s3_triggered-lambda-exec_role') }
end
