ActiveSupport.on_load(:active_record) do
  include Draped
end