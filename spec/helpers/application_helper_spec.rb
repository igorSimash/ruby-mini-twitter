# spec/helpers/application_helper_spec.rb
require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  describe '#format_body' do
    context 'when body contains multiple newlines' do
      let(:body) { "This is a tweet\n\n\n\nwith multiple newlines." }
      let(:expected_result) { "This is a tweet\n\nwith multiple newlines." }

      subject { helper.format_body(body) }

      it 'replaces multiple newlines with two newlines' do
        expect(subject).to eq(expected_result)
      end
    end

    context 'when body contains single or double newlines' do
      let(:body) { "This is a test\nwith single newline.\n\nThis is another paragraph." }

      subject { helper.format_body(body) }

      it 'does not modify text with single or double newlines' do
        expect(subject).to eq(body)
      end
    end

    context 'when body is empty' do
      let(:body) { "" }

      subject { helper.format_body(body) }

      it 'returns an empty string' do
        expect(subject).to eq("")
      end
    end
  end
end
