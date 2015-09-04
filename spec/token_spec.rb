describe 'token' do
	it "should store a value" do
		#Arrange
		token = Token.new('the value', nil) 
		
		#Act
		actual_value = token.value
		
		#Assert
		expect(actual_value).to eq('the value')
	end
	
  it "should store a number of types" do
      #Arrange
      token = Token.new('the value', nil) 
      
      #Act
      actual_value = token.value
      
      #Assert
      expect(actual_value).to eq('the value')
    end
	
	
end
