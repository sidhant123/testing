	class Bank
		attr_reader :name, :balance
		def initialize(name,balance=1000)
			@name=name
			@balance=balance
		end

		def display(pin_no)
			puts pin_no==pin ? "balance is #{@balance}": pin_error
		end

		def deposit(pin_no,amount)
			if pin_no==pin 
				@balance+=amount
			else
				pin_error
			end
		end

		def withdraw(pin_no,amount)
			if pin_no==pin
				@balance-=amount
			else
				pin_error
			end
		end


		private
		def pin
			@pin=1234
		end

		def pin_error
			puts "invalid pin"
		end
end

Sid=Bank.new("Sidhant",10000.to_i)
Sid.display(234)
Sid.deposit(1234,5000)
Sid.display(1234)
Sid.withdraw(1234,5000)
Sid.display(1234)
Sid.display(2345)