import SwiftUI

//add sublists for Browse Mode
// sublist for pvp mode
//include category selection for Browse Mode.

struct ProfilePage: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: Text("Stats Page under construction")) {
                    Text("Stats")
                }
                NavigationLink(destination: HistList()) {
                    Text("History")
                }
                Text("Tutorial")
                    .onTapGesture {
                        Globals.shared.showTutorial = true
                    }
                NavigationLink(destination: Text("Contact Me Page under construction")) {
                    Text("Contact Me")
                }
            }
            .navigationBarTitle(Text("Profile")).navigationBarHidden(false)
        }
    }
}
#Preview {
    ProfilePage()
}
