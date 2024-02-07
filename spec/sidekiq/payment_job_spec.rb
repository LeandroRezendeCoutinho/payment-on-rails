require 'rails_helper'

RSpec.describe PaymentJob, type: :job do
  it { is_expected.to be_retryable 5 }
  it { is_expected.to be_processed_in :default }

  describe '#perform' do
    let(:payment_id) { 123 }

    it 'calls PaymentService with the correct payment_id' do
      expect(PaymentService).to receive(:new).with(payment_id).and_return(double('PaymentService', call: nil))
      PaymentJob.new.perform(payment_id)
    end

    it 'calls the call method on PaymentService' do
      payment_service = instance_double('PaymentService', call: nil)
      allow(PaymentService).to receive(:new).and_return(payment_service)

      PaymentJob.new.perform(payment_id)

      expect(payment_service).to have_received(:call)
    end
  end

  describe '#enqueue' do
    let(:payment_id) { 123 }
    subject { PaymentJob.perform_async(payment_id) }

    it 'queue the job' do
      expect { subject }.to enqueue_sidekiq_job(PaymentJob).with(payment_id)
    end

    it 'queue on the default queue' do
      expect { subject }.to enqueue_sidekiq_job(PaymentJob).on('default')
    end
  end
end
