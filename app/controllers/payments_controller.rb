class PaymentsController < ApplicationController
	def new
		@job_listing = JobListing.find(params[:job_listing_id])
		@applied_job = @job_listing.applied_jobs.find_by(talent_id: params[:applicant_id])
		@talent = @applied_job.talent if @applied_job
		@amount = @job_listing.salary.to_i / 2
		@amount_in_dollars_in_cents = @amount * 100
		@job_status = "assigned"
	end

	def create
		@job_listing = JobListing.find(params[:job_listing_id])
		@applied_job = @job_listing.applied_jobs.find(params[:applied_job_id])
		@talent_id = @applied_job.talent_id
		@amount = @job_listing.salary.to_i / 2
		@amount_in_dollars_in_cents = @amount * 100
		
		begin
			if current_user.role_id == 3 
				customer = Stripe::Customer.create({
					email: params[:stripeEmail],
					source: params[:stripeToken],
				})

				charge = Stripe::Charge.create(
					customer: customer.id,
					amount: @amount_in_dollars_in_cents,
					description: 'Rails Stripe customer',
					currency: 'php'
				)

				result = Transaction.send_payment(current_user, params[:job_listing_id], params[:applied_job_id], params[:job_status])

				if result[:success]
					redirect_to job_listings_path, notice: result[:message]
				else
					redirect_to job_listings_path, alert: result[:message]
				end
			
			else
				flash[:error] = 'You are not authorized to make this payment.'
				redirect_to dashboard_path
			end

			rescue Stripe::StripeError => e
				flash[:error] = e.message
				redirect_to new_payment_path(job_listing_id: @job_listing.id, applicant_id: @talent_id)
		end
	end

	def new_complete
		@job_listing = JobListing.find(params[:job_listing_id])
		@applied_job = @job_listing.applied_jobs.find_by(talent_id: params[:applicant_id])
		@talent = @applied_job.talent if @applied_job
		@amount = @applied_job.balance if @applied_job
		@amount_in_dollars_in_cents = @amount * 100
		@job_status = "completed"

		render :new
	end
end
