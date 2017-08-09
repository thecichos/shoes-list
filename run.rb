require "rubygems"
require "json"
require "green_shoes"
require "unicode"


Shoes.app width: 600 do

  file = File.read("json/cars.json")

  def loadJson file
    return JSON.parse(file)
  end

  make_list = []
  model_list = []

  fileParsed = loadJson(file)

  interval_value = 0
  while interval_value != fileParsed.length
    if fileParsed[interval_value]["engine"]
      puts fileParsed[interval_value]["engine"]
    else

    end
    interval_value = interval_value + 1
  end


stack do
  def generate_make_list fileParsed, make_list
    # list the makes of the cars
    interval_value = 0
    while interval_value != fileParsed.length
      if make_list.include? fileParsed[interval_value]["make"]
      else
        make_list.push(fileParsed[interval_value]["make"])
      end
      interval_value = interval_value + 1
    end
    return make_list
  end
  make_list = generate_make_list fileParsed, make_list
  choice1 = ""
  choice2 = ""
  @make_list_choice = para "", margin: 10

  flow margin: 10 do
    @make_list = list_box items: make_list do |e|
      choice1 = e.text
      @make_list_choice.text = "#{choice1} #{choice2}"
      interval_value = 0

      # list the models of the cars

      model_list = []
      while interval_value != fileParsed.length
        if fileParsed[interval_value]["make"] == e.text
          model_list.push(fileParsed[interval_value]["model"])

        end
        interval_value = interval_value + 1
      end
      @model_list.items = model_list
      re = @model_list.items
      @model_list.choose re[0]
    end
  end
  flow margin: 10 do
      @model_list = list_box items: model_list do |e|
      choice2 = e.text
      @make_list_choice.text = "#{choice1} #{choice2}"
    end
  end
  re = @make_list.items
  @make_list.choose re[0]
  re = @model_list.items
  @model_list.choose re[0]
end
stack margin: 10 do
  @error = para
  flow do
    para "please write a car manufacurer", margin: 5
    @add_make = edit_line " ", margin: 5
  end
  flow do
    para "please write a car model", margin: 5
    @add_model = edit_line " ", margin: 5
  end
  @confirm = button "confirm" do
    if @add_make.text.to_s.empty?
        @error.replace("you need to fill the make line")
        timer 5 do
          @error.replace(" ")
        end
    elsif @add_model.text.to_s.empty?
        @error.replace("you need to fill the model line")
        timer 5 do
          @error.replace(" ")
        end
    else
      interval_value = 0
      while interval_value != fileParsed.length
          if fileParsed[interval_value]["model"] == @add_model.text.capitalize
            @error.replace("this is already in the library")
            break
          end
          temp = {"make" => @add_make.text.capitalize,"model" => @add_model.text.capitalize}
          fileParsed << temp
          File.open("json/cars.json", "w") do |f|
            f.puts JSON.pretty_generate(fileParsed)
            f.close

          end

          file = File.read("json/cars.json")

          fileParsed = loadJson(file)

          make_list = generate_make_list(fileParsed, make_list)

          @make_list.items = []
          @make_list.items = make_list

          re = @make_list.items
          @make_list.choose re[0]

          puts @make_list.items

          break
        interval_value = interval_value + 1
      end

      end
    end
  end

end
