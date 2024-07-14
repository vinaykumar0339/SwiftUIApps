import SwiftUI
import SDWebImageSwiftUI

struct WeatherCardItem: View {
    
    @ObservedObject var weatherCardItemViewModel: WeatherCardItemViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(weatherCardItemViewModel.date)
                .font(.caption) // Use a smaller font for the date
            
            HStack(alignment: .top, spacing: 10) {
                WebImage(url: weatherCardItemViewModel.weatherIconUrl)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50, height: 50)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(8)
                    .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
                
                VStack(alignment: .leading, spacing: 5) {
                    Text(weatherCardItemViewModel.temp)
                        .font(.title3)
                        .fontWeight(.medium)
                        .foregroundColor(.blue)
                    
                    Text(weatherCardItemViewModel.description)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    HStack {
                        Text(weatherCardItemViewModel.highTemp)
                        Text(weatherCardItemViewModel.lowTemp)
                    }
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    
                    Text(weatherCardItemViewModel.humidity)
                        .font(.subheadline)
                        .bold()
                        .foregroundColor(.gray)
                }
            }
            .padding(10)
            .background(Color.white)
            .cornerRadius(10)
            .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
        }
        .padding(10)
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .shadow(color: Color.gray.opacity(0.5), radius: 5, x: 0, y: 2)
    }
}

struct Preview_WeatherCardItem: PreviewProvider {
    static var previews: some View {
        WeatherCardItem(weatherCardItemViewModel: WeatherCardItemViewModel(forecast: ForeCast.sample, tempUnits: .celsius))
            .previewLayout(.sizeThatFits)
    }
}

