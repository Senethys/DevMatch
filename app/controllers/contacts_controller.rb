class ContactsController < ApplicationController
    
    # GET request to /cintact-me 
    # Show new contact form
    def new
        @contact = Contact.new
    end
    
    # POST request /contacts
    def create
        # Mass assignment of form fields into contact object
        @contact = Contact.new(contact_params)
        # Save contact object to db. 
        if @contact.save
            # Stora form fields via params into variables.
            name = params[:contact][:name]
            email = params[:contact][:email]
            body = params[:contact][:comments]
            # Plug variables into Contact Mailer
            # email method and send email
            ContactMailer.contact_email(name, email, body).deliver
            # Store success message in flahs hash
            # and redirect to the new action
            flash[:success] = "Message sent!"
            redirect_to new_contact_path
        else
            # If contact object doesn't save, store errors in flahs hash
            # and redirect to the new action
            flash[:danger] = @contact.errors.full_messages.join(", ")
            redirect_to new_contact_path
        end
    end
    
    
    private
    # To collect data from form we need to use strong params
    # And white list the form fields.
        def contact_params
            params.require(:contact).permit(:name, :email, :comments)
        end
end