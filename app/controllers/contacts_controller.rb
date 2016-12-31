class ContactsController < ApplicationController
  
  # GET request to /contact_us
  # Shows fresh contact form ready for use
  def new
    @contact = Contact.new
  end
  
  # POST request to /contacts
  def create
    # assigns form field contents to Contact object
    @contact = Contact.new(contact_params)
    # saves Contact object to database if all fields valid
    if @contact.save
      # Store form field contents via parameters
      # as variables
      name = params[:contact][:name]
      email = params[:contact][:email]
      body = params[:contact][:comments]
      # Put variables into Contact Mailer email method
      # and send 
      ContactMailer.contact_email(name, email, body).deliver
      # Store success message in flash hash
      # and redirect to new action
      flash[:success] = "Message sent."
      redirect_to new_contact_path
    else
      # If Contact object does not save
      # Store error messages in flash hash
      # redirect back to new action
      flash[:danger] = @contact.errors.full_messages.join(". ")
      redirect_to new_contact_path
    end
  end
  
  private
    # Best practice: use Strong parameters
    # to collect data from form fields
    # and whitelist form fields
    def contact_params
      params.require(:contact).permit(:name, :email, :comments)
    end
end
