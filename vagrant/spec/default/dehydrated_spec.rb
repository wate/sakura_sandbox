require 'spec_helper'

describe package('dehydrated') do
  it { should be_installed }
end
