//
//  ContentView.swift
//  Moonshot
//
//  Created by Михаил Тихомиров on 18.04.2023.
//

import SwiftUI




struct ContentView: View {
    // we use generic to load any kind of codable data we want
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    let columns = [
        GridItem(.adaptive(minimum: 150))    // adaprive means it will squeeze in as many rows as it can to fit
    ]
    
    @State private var showingGrid = false
    
    
    var body: some View {
        NavigationView {
            Group {
                if showingGrid {
                    GridLayout()
                }else {
                    ListLayout()
                }
            }
            .toolbar {
                Button {
                    showingGrid.toggle()
                }label: {
                    Text ("mode")
                    Image(systemName: "slider.horizontal.3")
                }
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
        }
        
    }
    
    func GridLayout()->some View {
        return ScrollView{
            LazyVGrid(columns: columns){
                ForEach(missions) {mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        VStack {
                            Image (mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()
                                
                            
                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                                Text (mission.formattedLaunchDate)
                                    .font (.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth:.infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    func ListLayout()->some View {
        return List {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    }label: {
                        VStack {
                            Image (mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()


                            VStack{
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)

                                Text (mission.formattedLaunchDate)
                                    .font (.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth:.infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    }
                }
            .padding([.horizontal, .bottom])
        }
        .listStyle(.plain)
        .listRowBackground(Color.darkBackground)
    }
    
    
}
    

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


