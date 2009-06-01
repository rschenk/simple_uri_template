require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe SimpleURITemplate do
  describe '#expand' do
    before(:each) do
      @template = SimpleURITemplate.new "http://example.com?q={query}&t={term}"
    end

    it "should accept a hash with String keys" do
      @template.expand({'query' => 'dude', 'term' => 'bro'}).should == 'http://example.com?q=dude&t=bro'
    end
    
    it "should accept a hash with Symbol keys" do
      @template.expand({:query => 'dude', :term => 'bro'}).should == 'http://example.com?q=dude&t=bro'
    end
    
    
    it 'should ignore pairs in the hash that are not in the template' do
      @template.expand({:query => 'dude', :term => 'bro', :salami => 'egad'}).should == 'http://example.com?q=dude&t=bro'
    end
    
    it 'should URI encode the values' do
      @template.expand({:query => 'dude bro', :term => 'bro dude'}).should == 'http://example.com?q=dude%20bro&t=bro%20dude'
    end
    
    it 'should gracefully handle values that are not Strings' do
      @template.expand({:query => 1, :term => true}).should == 'http://example.com?q=1&t=true'
    end
  end
end