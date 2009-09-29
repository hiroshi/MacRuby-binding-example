#
# MyDocument.rb
# array_controller_test
#
# Created by hiroshi on 09/09/28.
# Copyright __MyCompanyName__ 2009. All rights reserved.
#

class Item
  def initialize(hash=nil)
    @hash = {"name" => "new item"}.merge(hash || {})
  end

  def valueForUndefinedKey(key)
    @hash[key]
  end
  
  def setValue(value, forUndefinedKey:key)
    p value
    @hash[key] = value
  end
  
  def copyWithZone(zone)
    self.class.new(@hash)
  end

  def to_h
    @hash.dup
  end
=begin
  def method_missing(symbol, *args)
    p symbol
  end
  
  def methodSignatureForSelector(selector)
    p selector
  end

  def forwardInvocation(invocation)
    p invocation
    if @hash.respondsToSelector(invocation.selector)
      invocation.invokeWithTarget(@hash)
    else
      self.oesNotRecognizeSelector(invocation.selector)
    end
  end
=end
end

class MyDocument < NSDocument
    # for array controller
	def array
      @array ||= [{"name" => "foo"}, {"name" => "bar"}].map{|h| Item.new(h)}
    end
    def setArray(items)
      p items
      p items.map(&:to_h)
      @array = items
    end
    # for dictionary controller
    def dictionary
      @dict ||= {"1" => {"name" => "foo"}, "2" => {"name" => "bar"}}.inject({}){|h,e| h.update(e[0] => Item.new(e[1]))}
    end
    def setDictionary(items)
      p items
      p items.inject({}){|h,e| h.update(e[0] => e[1].to_h)}
      @dict = items
    end
    def initialDictionaryKey
      p "initialDictornaryKey"
      dictionary.keys.max
    end
    def initialDictionaryValue
      Item.new
    end

	# Name of nib containing document window
	def windowNibName
		'MyDocument'
	end
	
	# Document data representation for saving (return NSData)
	def dataOfType(type, error:outError)
		outError.assign(NSError.errorWithDomain(NSOSStatusErrorDomain, code:-4, userInfo:nil))
		nil
	end

	# Read document from data (return non-nil on success)
	def readFromData(data, ofType:type, error:outError)
		outError.assign(NSError.errorWithDomain(NSOSStatusErrorDomain, code:-4, userInfo:nil))
		nil
	end

	# Return lowercase 'untitled', to comply with HIG
	def displayName
		fileURL ? super : super.sub(/^[[:upper:]]/) {|s| s.downcase}
	end

end
