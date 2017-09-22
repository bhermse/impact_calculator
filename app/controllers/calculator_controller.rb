require 'rest-client'
class CalculatorController < ApplicationController
  # "zip" : five-character string; zip code
  # "hhsize" : integer > 0; number of people in household
  # "minors" : integer >= 0; number of minors in household
  # "age" : integer >= 18; age of head of household
  # "income" : numeric > 0;

  # response = RestClient.post(IMPACT_STUDY_URL,  '{"input" : [ {"zip":"80524", "hhsize":4, "minors":2, "age":50, "income":50000} ]}', {content_type: :json, accept: :json})

  IMPACT_STUDY_URL = 'https://ummel.ocpu.io/exampleR/R/predictModel/json'
  def home

  end

  def calculate
    if valid_search? params
      inputs = {input: [{
          zip: params[:zip],
          hhsize: params[:adults].to_i + params[:minors].to_i,
          minors: params[:children].to_i,
          age: params[:age].to_i,
          income: params[:income].to_i
      }]}.to_json

      response = RestClient.post(IMPACT_STUDY_URL, inputs, {content_type: :json, accept: :json})

      outputs = JSON.parse(response.body).first

      render(locals: {pre_tax: outputs['div_pre'], tax_bracket: outputs['mrate'], electricity_preset: outputs['elec'], gas_preset: outputs['gas'], cost_formula: outputs['cost']})
    end
  end

  private

  def valid_search? params
    [params[:zip], params[:adults], params[:children], params[:age], params[:income]].all?(&:present?)
  end
end
