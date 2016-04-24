module WelcomeHelper
	def self.toDurationString(duration_setting)
		if duration_setting == 'arrive'
			return "Until I Arrive"
		elsif duration_setting[-4..-1] == 'hour' or duration_setting[-5..-1] == 'hours'
			if duration_setting[1] == ' '
				number = duration_setting[0]
			else
				number = duration_setting[0..1]
			end
			s = 's'
			if number == '1'
				s = ''
			end
			return "For "+number+" Hour"+s
		elsif duration_setting[0..4] == 'until'
			if duration_setting[7] == ' '
				number = duration_setting[6]
			else
				number = duration_setting[6..7]
			end
			ampm = ''
			if duration_setting[-2..-1] == 'am'
				ampm = 'am'
			elsif duration_setting[-2..-1] == 'pm'
				ampm = 'pm'
			end
			clarify12 = ''
			if number == '12'
				if ampm == 'am'
					clarify12 = ' Midnight'
				else
					clarify12 = ' Noon'
				end 
			end
			return "Until "+number+" "+ampm+clarify12
		else
			return duration_setting
		end
	end
end
