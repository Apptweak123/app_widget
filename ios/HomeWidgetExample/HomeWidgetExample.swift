import SwiftUI
import WidgetKit

private let widgetGroupId = "group.com.example.appwidget.HomeWidgetExample"

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> ExampleEntry {
        ExampleEntry(
            date: Date(),
            title: "Placeholder Title",
            message: "Placeholder Message",
            hijriDate: "9 Rabi al Thani 1446",
            prayerTimes: [
                "Fajr": "7:32",
                "Sharooq": "7:32",
                "Duhar": "06:04",
                "Asr": "06:04",
                "Magrib": "06:04",
                "Isha": "06:04"
            ]
        )
    }
    
    func getSnapshot(in context: Context, completion: @escaping (ExampleEntry) -> Void) {
        let data = UserDefaults.init(suiteName: widgetGroupId)
        let entry = ExampleEntry(
            date: Date(),
            title: data?.string(forKey: "title") ?? "No Title Set",
            message: data?.string(forKey: "message") ?? "No Message Set",
            hijriDate: data?.string(forKey: "hijriDate") ?? "Unknown Hijri Date",
            prayerTimes: [
                "Fajr": data?.string(forKey: "Fajr") ?? "--:--",
                "Sharooq": data?.string(forKey: "Sharooq") ?? "--:--",
                "Duhar": data?.string(forKey: "Duhar") ?? "--:--",
                "Asr": data?.string(forKey: "Asr") ?? "--:--",
                "Magrib": data?.string(forKey: "Magrib") ?? "--:--",
                "Isha": data?.string(forKey: "Isha") ?? "--:--"
            ]
        )
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
        getSnapshot(in: context) { (entry) in
            let timeline = Timeline(entries: [entry], policy: .atEnd)
            completion(timeline)
        }
    }
}



struct ExampleEntry: TimelineEntry {
    let date: Date
    let title: String
    let message: String
    let hijriDate: String
    let prayerTimes: [String: String]
}




struct HomeWidgetExampleEntryView: View {
    var entry: Provider.Entry
    @State private var geometrySize = CGSize(width: 0, height: 0)
    var body: some View {
        
        GeometryReader { geometry in
            VStack.init(
                alignment: .center,
                spacing: 0,
                content:{
                    
                    if(geometry.size.width < 160){

                        VStack(spacing: 0) {
                            LazyVStack(spacing: 0) {
                                Text("Asr")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .frame(maxWidth: geometry.size.width, alignment: .leading)
                                .padding(.leading, 20)
                                    
                               
                                Text("PM")
                                .font(.system(size: 19, weight: .bold))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.trailing)
                                .frame(maxWidth: geometry.size.width, alignment: .trailing)
                                .padding(.trailing, 20)
                                Text("06:04")
                                    .font(.system(size: 40, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.center)
                                    .frame(maxWidth: geometry.size.width, alignment: .center)
                            }
                            .frame(maxWidth: geometry.size.width,maxHeight: geometry.size.height, alignment: .center)
                            HStack(spacing: 27) {
                            
                              Text("PM")
                                    .font(.system(size: 19, weight: .bold))
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.trailing)
                                    .frame(maxHeight: geometry.size.height, alignment: .top)
                                Image(systemName: "sunrise")
                                    .resizable()
                                    .foregroundColor(Color.white)
                                    .frame(width: 61,height: 51)
                                    .scaledToFit()
                            }
                            .frame(maxWidth: geometry.size.width,maxHeight: geometry.size.height, alignment: .center)
                        }
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .background(Color(hex: "#0D7538"))

                    } else {
                        VStack(spacing: 0) {
                            VStack(spacing: 0) {
                                Text(entry.hijriDate)
                                    .font(.system(size: 16, weight: .bold))
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 8,leading: 0,bottom: 4,trailing: 0))
                                Text(entry.date, style: .date)
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundColor(.white)
                                    .padding(EdgeInsets(top: 0,leading: 0,bottom: 8,trailing: 0))
                            }
                            .frame(width: geometry.size.width, height: 55, alignment: .top)
                            .background(Color(hex: "#0D7538"))
                            .cornerRadius(12, corners: [.topLeft, .topRight])
                            if geometry.size.height < 200 {
                              //  ScrollView(.horizontal, showsIndicators: false) {
                                    LazyHStack(spacing: 0) {
                                        ForEach(entry.prayerTimes.sorted(by: { $0.key < $1.key }), id: \.key) { (name, time) in
                                            VStack(spacing: 5) {
                                                let hexColor = name == "Asr" ?  "#D8FDD2"  : "#F9F9F9";
                                                ZStack {
                                                    Circle()
                                                        .fill(Color(hex: hexColor))
                                                        .frame(width: 33, height: 33)
                                                    Image(systemName: getPrayerIcon(for: name))
                                                        .font(.caption)
                                                        .foregroundColor(Color(hex: "0D7538"))
                                                }.padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                                                Text(name)
                                                    .font(.system(size: 10, weight: .bold))
                                                    .foregroundColor(.black)
                                                Text(time)
                                                    .font(.system(size: 8, weight: .semibold))
                                                    .foregroundColor(Color(hex: "#868686"))
                                                    .padding(.bottom)
                                            }
                                            .background(name == "Asr" ? Color(hex: "#D8FDD2") : Color.white)
                                            .cornerRadius(8)
                                        }
                                    }
                                    .frame(width: geometry.size.width, height: geometry.size.height - 55, alignment:Alignment.center)
                                    .background(Color.white)
//                                }
//                                .frame(width: geometry.size.width, height: geometry.size.height - 55, alignment:Alignment.center)
//                                .background(Color.white)
                            } else {
                                VStack(alignment: .leading, spacing: 8) {
                                    ForEach(entry.prayerTimes.sorted(by: { $0.key < $1.key }), id: \.key) { (name, time) in
                                        HStack {
                                            Text(name)
                                                .font(.headline)
                                                .foregroundColor(.black)
                                            Spacer()
                                            Text(time)
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                    }
                                }
                                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height - 51 , alignment: Alignment.top)
                                .background(Color.white)
                                .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                            }
                        }.frame(width: geometry.size.width, height: geometry.size.height)
                    }
                    
                }
            )
        }
    }
    func getPrayerIcon(for prayerName: String) -> String {
        switch prayerName {
        case "Fajr": return "sunrise"
        case "Sharooq": return "arrow.up.circle"
        case "Duhar": return "sun.max"
        case "Asr": return "sun.max.fill"
        case "Magrib": return "sunset"
        case "Isha": return "moon"
        default: return "clock"
        }
    }
}



@main
struct HomeWidgetExample: Widget {
    let kind: String = "HomeWidgetExample"
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            HomeWidgetExampleEntryView(entry: entry)
        }
        
        .contentMarginsDisabled()
        .configurationDisplayName("Home Widget Example")
        .description("This is an example widget.")
    }
}

struct HomeWidgetExample_Previews: PreviewProvider {
    static var previews: some View {
        HomeWidgetExampleEntryView(
            entry: ExampleEntry(
                date: Date(),
                title: "Example Title",
                message: "Example Message",
                hijriDate: "9 Rabi al Thani 1446",
                prayerTimes: [
                    "Fajr": "5:00",
                    "Sharooq": "6:30",
                    "Duhar": "12:00",
                    "Asr": "15:30",
                    "Magrib": "18:00",
                    "Isha": "19:30"
                ]
            )
        )
        .previewContext(WidgetPreviewContext(family: .systemSmall))
        .background(Color.red)
    }
}




//struct HomeWidgetExampleEntryView: View {
//  var entry: Provider.Entry
//  let data = UserDefaults.init(suiteName: widgetGroupId)
//  let iconPath: String?
//
//  init(entry: Provider.Entry) {
//    self.entry = entry
//    iconPath = data?.string(forKey: "dashIcon")
//
//  }
//
//  var body: some View {
//    VStack.init(
//      alignment: .center,
//      spacing: nil,
//      content: {
//        if #available(iOSApplicationExtension 17, *) {
//          Button(
//            intent: BackgroundIntent(
//              url: URL(string: "homeWidgetExample://titleClicked"), appGroup: widgetGroupId)
//          ) {
//            Text(entry.title).bold().font(
//              .title)
//          }.buttonStyle(.plain).frame(maxWidth: .infinity, alignment: .leading)
//        } else {
//          Text(entry.title).bold().font(
//            .title
//          ).frame(
//            maxWidth: .infinity, alignment: .leading)
//        }
//        Text(entry.message)
//          .font(.body)
//          .widgetURL(URL(string: "homeWidgetExample://message?message=\(entry.message)&homeWidget"))
//          .frame(maxWidth: .infinity, alignment: .leading)
//        if iconPath != nil {
//          Image(uiImage: UIImage(contentsOfFile: iconPath!)!).resizable()
//            .scaledToFill()
//            .frame(width: 64, height: 64)
//        }
//      }
//    )
//  }
//}
