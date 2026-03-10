import EventKit
import Foundation

let store = EKEventStore()
let sem = DispatchSemaphore(value: 0)

store.requestFullAccessToEvents { granted, _ in
    if granted {
        let now = Date()
        let endOfDay = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: now)!
        let startOfDay = Calendar.current.startOfDay(for: now)
        let predicate = store.predicateForEvents(withStart: startOfDay, end: endOfDay, calendars: nil)
        let events = store.events(matching: predicate)
            .filter { !$0.isAllDay && $0.endDate > now }
            .sorted { $0.startDate < $1.startDate }

        if let event = events.first {
            let fmt = DateFormatter()
            fmt.dateFormat = "H:mm"
            print("\(fmt.string(from: event.startDate)) \(event.title ?? "")")
        }
    }
    sem.signal()
}
sem.wait()
