# frozen_string_literal: true

describe ArticlesManagement::Index::UserService, type: :service do
  let(:service) { described_class.new(**args) }
  let(:args) { {} }

  describe '#articles' do
    subject(:articles) { service.articles }

    context 'with empty args' do
      it { expect { articles }.to raise_error(SystemManagement::ServiceExceptions::AbstractMethodCalled) }
    end
  end
end
