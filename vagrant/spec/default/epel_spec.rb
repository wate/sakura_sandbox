require 'spec_helper'

describe yumrepo('epel') do
  it { should exist }
  it { should be_enabled }
end
