class DeleteMailer < ActionMailer::Base
  default from: 

  def reason_to_delete(tip)
    @tip = tip

    mail(to: "michael.r.bukowski@gmail.com", 
         subject: "Reason for deleting a tip")
  end
end
