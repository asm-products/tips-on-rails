class DeleteMailer < ActionMailer::Base
  default from: 'Tips on rails user'

  def reason_to_delete(tip, message)
    @tip = tip
    @message = message

    mail(
      to: 'michael.r.bukowski@gmail.com',
      subject: 'Reason for deleting a tip'
    )
  end
end
