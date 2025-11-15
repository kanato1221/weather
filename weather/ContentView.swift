import SwiftUI

struct ContentView: View {
    @State var cityWeather: CityWeather = .tokyo
    
    var body: some View {
        ZStack{
            LinearGradient(colors: [.blue, .white], startPoint: .topLeading, endPoint: .bottomLeading)
                .ignoresSafeArea()
            ScrollView{
                VStack{
                    Text(cityWeather.cityName)
                        .font(.system(size: 48, weight: .light))
                    Text("\(cityWeather.dailyForecast.hourlyWeather.first!.temperature)°C")
                        .font(.system(size: 96, weight: .thin))
                    HStack{
                        Text("最高")
                        Text("\(cityWeather.dailyForecast.highestTemperature)°")
                        Text("最低")
                        Text("\(cityWeather.dailyForecast.lowestTemperature)°")
                    }
                    .font(.system(size: 24, weight: .light))
                }
                VStack(spacing: 8){
                    Text(cityWeather.dailyForecast.description)
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    ScrollView(.horizontal){
                        LazyHStack(spacing: 16){
                            ForEach(cityWeather.dailyForecast.hourlyWeather){Weather in
                            VStack(spacing: 8){
                                Text("\(Weather.hour):00")
                                    .font(.system(size: 16))
                                Image(systemName: Weather.condition.symbolName)
                                    .symbolRenderingMode(.multicolor)
                                    .font(.system(size: 28))
                                Text("\(Weather.temperature)°")
                                    .font(.system(size: 20))
                                }
                            .frame(width: 60)
                            }
                        }
                    }
                }
                .padding(10)
                .background(Color.black.opacity(0.1))
                .cornerRadius(16)
                .padding(.horizontal, 24)
                
                LazyVStack(spacing: 20){
                    Text("7日間の天気予報")
                        .font(.system(size: 16))
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Divider()
                    ForEach(cityWeather.weeklyForecast){ forecast in
                        HStack(spacing: 16){
                            Text(forecast.day)
                                .frame(width: 40,  alignment: .leading)
                            Image(systemName: forecast.hourlyWeather.first!.condition.symbolName)
                                .symbolRenderingMode(.multicolor)
                                .font(.system(size: 24))
                            VStack(){
                                Text("最低　最高 ")
                                Text("\(forecast.lowestTemperature)°  \(forecast.highestTemperature)°)")
                            }
                            VStack{
                                Text("最高気温ゲージ")
                                    .font(.system(size: 16))
                                    .frame(width: .infinity
                                    )
                                Gauge(value: Double(forecast.highestTemperature), in: 25...35){}
                                    .gaugeStyle(.accessoryCircular)
                                    .tint(Gradient(colors: [.yellow, .orange]))
                                    .frame(width: 120,)
                                    .font(.system(size: 20))
                                    .foregroundStyle(.white)
                            }
                        }
                        .font(system(size: 20))
                        .padding(.horizontal)
                        Divider()
                    }
                }
                .padding()
                .background(Color.black.opacity(0,1))
                .cornerRadius(16)
                .padding(.horizontal, 24)
            }
        }
        .foregroundStyle(.white)
        .shadow(radius:3)
    }
}

#Preview {
    ContentView()
}
