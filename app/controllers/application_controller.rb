class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  # 全ページログイン必須ですよ。

end
