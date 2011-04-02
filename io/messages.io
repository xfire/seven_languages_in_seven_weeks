postOffice := Object clone
postOffice packageSender := method(call sender)

mailer := Object clone
mailer deliver := method(postOffice packageSender)
mailer deliver println

postOffice messageTarget := method(call target)
postOffice messageTarget println

postOffice messageArgs := method(call message arguments)
postOffice messageArgs("one", 2, :three) println

postOffice messageName := method(call message name)
postOffice messageName println
