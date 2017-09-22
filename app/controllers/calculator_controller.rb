require 'rest-client'
class CalculatorController < ApplicationController
  # response = RestClient.post(IMPACT_STUDY_URL,  '{"input" : [ {"zip":"80524", "hhsize":4, "minors":2, "age":50, "income":50000} ]}', {content_type: :json, accept: :json})

  IMPACT_STUDY_URL = 'https://ummel.ocpu.io/exampleR/R/predictModel/json'
  def home
  end

  def calculate
    if valid_search? params
      inputs = {input: [{
          zip: params[:zip],
          hhsize: params[:adults].to_i + params[:children].to_i,
          minors: params[:children].to_i,
          age: params[:age].to_i,
          income: params[:income].to_i
      }]}.to_json

      response = RestClient.post(IMPACT_STUDY_URL, inputs, {content_type: :json, accept: :json})

      outputs = JSON.parse(response.body).first

      render(locals: {pre_tax: outputs['div_pre'], tax_bracket: outputs['mrate'], electricity_preset: outputs['elec'],
                      gas_preset: outputs['gas'], cost_formula: outputs['cost'], cost: get_cost(outputs)})
    end
  end

  private

  def valid_search? params
    [params[:zip], params[:adults], params[:children], params[:age], params[:income]].all?(&:present?)
  end

  def get_cost(outputs)
    elec = outputs['elec']
    gas = outputs['gas']
    sprintf('%.2f', (eval outputs['cost']))
  end
end
