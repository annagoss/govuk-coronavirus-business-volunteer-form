# frozen_string_literal: true

class CoronavirusForm::CheckAnswersController < ApplicationController
  include ActionView::Helpers::SanitizeHelper

  def show
    session[:check_answers_seen] = true
    render "coronavirus_form/check_answers"
  end

  def submit
    submission_reference = reference_number

    session[:reference_number] = submission_reference
    FormResponse.create(form_response: session)

    reset_session

    redirect_to controller: "coronavirus_form/thank_you", action: "show", reference_number: submission_reference
  end

private

  def reference_number
    timestamp = Time.zone.now.strftime("%Y%m%d-%H%M%S")
    random_id = SecureRandom.hex(3).upcase
    "#{timestamp}-#{random_id}"
  end
end
