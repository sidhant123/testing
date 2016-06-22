class Encryptor
	def cipher(rotation)
		char=(' '..'z').to_a
		rot_char=char.rotate(rotation)
		Hash[char.zip(rot_char)]
	end
	def encrypt_letter(letter,rotation)
		cipher_for_rotation=cipher(rotation)
		cipher_for_rotation[letter]
	end		
	def encrypt(string,rotation)
		letters=string.split("")
		result=[] 	
		letters.each do |letter|
		encrypted_letter=encrypt_letter(letter,rotation)
		result.push(encrypted_letter)
		end
		result.join

	end		
	def decrypt(string,rotation)
		encrypt(string,-rotation)	
	end
	def encrypt_file(filename,rotation)
		input=File.open(filename,"r")
		input_text=input.read
		encrypted_text=encrypt(input_text,rotation)
		output_filename=filename + ".encrypted"
		output=File.open(output_filename,"w")
		output.write(encrypted_text)
		output.close

	end
	def decrypt_file(filename,rotation)
		input=File.open(filename,"r:ASCII-8BIT")
		input_text=input.read
		decrypted_text=decrypt(input_text,rotation)
		output_filename=filename.gsub("encrypted","decrypted")
		output=File.open(output_filename,"w")
		output.write(decrypted_text)
		output.close

	end
	def supported_characters
		(' '..'z').to_a
	end

	def crack(message)
		supported_characters.count.times.collect do |attempt|
		decrypt(message,attempt)
		end
	end

end
		