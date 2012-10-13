require 'rspec/mocks'

class RSpec::Mocks::AnyInstance::StubChain
  record :and_return_self

  def playback!(instance)
    messages.inject(instance) do |_instance, message|
      if message.first == [:and_return_self]
        _instance.__send__(:and_return, instance)
      else
        _instance.__send__(*message.first, &message.last)
      end
    end
  end

  def invocation_order
    @invocation_order ||= {
      :stub => [nil],
      :with => [:stub],
      :and_return_self => [:with, :stub],
      :and_return => [:with, :stub],
      :and_raise => [:with, :stub],
      :and_yield => [:with, :stub]
    }
  end
end
