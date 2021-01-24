import java.util.Map;

static class status {
   enum State {A,B,C};
}

class Grid {

  HashMap<String,Integer> led_map;
  HashMap<String,Pixel> map;
  RShape grp;
  RShape cLine;
  RPoint[] onLine;
  status.State current_state;
  int index;
  int led_index;

  Grid(RShape svg, status.State init_status){
    index = 0;
    grp = svg;
    led_map = new HashMap<String,Integer>();
    map = new HashMap<String,Pixel>();
    current_state = init_status;
    // VERY IMPORTANT: Allways initialize the library before using it
    grp.centerIn(g, 100, 1, 1);
    println(grp.countChildren());

    // Construct map
    for(int i=0;i<grp.countChildren();i++){
      println(grp.children[i].name);
      Pixel p = new Pixel(grp.children[i].name);
      map.put(grp.children[i].name, p);
    }

    for (int i = 0; i < 24; i++) {
      Pixel p = map.get("H0T" + str(i));
      p.set_id(i);
      map.put("H0T" + str(i), p);
    }
    for (int i = 0; i < 20; i++) {
      Pixel p = map.get("P0T" + str(i));
      p.set_id(i+24);
      map.put("P0T" + str(i), p);
    }
    // for (int i = 0; i < 24; i++) {
    //   led_map.put("H1T" + str(i), i+48);
    //   Pixel p = new Pixel(i+48);
    //   p.set_id(i+24);
    //   map.put("H1T" + str(i), p);
    // }
    // //led_map.put("P0T0", 24);
    // for (int i = 0; i < 24; i++) {
    //   led_map.put("H2T" + str(i), i+64);
    //   Pixel p = new Pixel(i+64);
    //   p.set_id(i+24);
    //   map.put("H2T" + str(i), p);
    // }
    // for (int i = 0; i < 24; i++) {
    //   led_map.put("H3T" + str(i), i+88);
    //   Pixel p = new Pixel(i+88);
    //   p.set_id(i+24);
    //   map.put("H3T" + str(i), p);
    // }
  }

  void increment_index(){
    index += 1;
    println(index);
  }
  void increment_led_index(){
    led_index += 1;
    println(led_index);
  }
  void decrement_index(){
    index -= 1;
    println(index);
  }
  void decrement_led_index(){
    led_index -= 1;
    println(led_index);
  }
  void update_state(status.State state){
    print("Updating");
    current_state = state;
  }

  void display(){
    switch (current_state) {
        case A :
            //println("A");
            break;
        case B :
            //println("B");
            fill(255);
            grp.children[index].draw();
            for(int i=0;i<grp.countChildren();i++){
              if(i == led_index){
                opc.setPixel(i, color(0, 100, 20));
              }
              else{
                opc.setPixel(i, color(0, 0, 0));
              }
            }
            noFill();
            break;
        case C :
            //println("C");
            break;
    }
    // for (Map.Entry entry : map.entrySet()) {
    //   Pixel p = map.get(entry.getKey());
    //   if (p.is_on()){
    //     fill(255);
    //     grp.getChild(p.name).draw();
    //     opc.setPixel(p.id, color(0, 100, 20));
    //   }
    //   else{
    //     noFill();
    //     opc.setPixel(p.id, color(0, 0, 0));
    //   }
    // }
    grp.draw();
    opc.writePixels();
  }

  void contains(int x, int y){
    RPoint p = new RPoint(x, y);
    //RPoint p = new RPoint(mouseX-width/2, mouseY-height/2);
    for(int i=0;i<grp.countChildren();i++){
      if (grp.children[i].contains(p)) {
        Pixel pix = map.get(grp.children[i].name);
        pix.get_id();
        pix.toggle();
      }
    }
  }
}