class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[home about]

  def home; end

  def profile
    @user = current_user
    @data_keys = [
      'January 21',
      'February 21',
      'March 21',
      'April 21',
      'May 21',
      'June 21',
      'July 21',
      'August 21',
      'September 21',
      'October 21',
      'November 21',
      'December 21',
      'January 22',
      'February 22',
      'March 22',
      'April 22',
      'May 22',
      'June 22',
      'July 22',
      'August 22',
      'September 22',
      'October 22',
      'November 22',
      'December 22'
    ]
    @data_values = [100, 400, 175, 200, 50, 350, 600]
  end

  def about; end
end
