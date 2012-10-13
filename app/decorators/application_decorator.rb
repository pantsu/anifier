class ApplicationDecorator < Draper::Base

  def self.helper
    _helper = Module.new
    _helper.send :include, ::LocaleHelpers, ::TimeHelper
    _helper
  end

  def self.default_context
    base = ActionView::Base.prepare(Rails.application.routes, helper)
    base.default_url_options = ActionMailer::Base.default_url_options.dup
    base.new
  end

  def helpers
    Thread.current[:current_view_context] ||= self.class.default_context
    super
  end

  alias :h :helpers

end
