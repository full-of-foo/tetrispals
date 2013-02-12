class ApplicationController < ActionController::Base
  include SessionsHelper
  include MicropostsHelper
  include HighScoresHelper
  protect_from_forgery
end
