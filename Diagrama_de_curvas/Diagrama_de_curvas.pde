//crea una tabla que guarda los datos del archivo .csv
Table table;

//me da el valor maximo 
int maxDato;

//numero de filas en el archivo
int rowCount;

//segundo
String [] tiempo; 

PFont titulo;
PFont etiquetas;
//tercero
//creo arreglos, que guardan los valores de cada columna
int [] suba;
int datoSuba = 0;

int xTexto = 65;
int xElipse = 50;
//cuarto
int [] kennedy;
int datoKennedy = 0;


//quinto
int [] lasFerias;
int datoLasFerias = 0;
int [] carvajal;
int datoCarvajal = 0;

void setup() 
{
  background(#ffffff);
  size(600,400);
  
  table = loadTable("datosCalidadAireCompleto.csv", "header");
  
  //numero de filas en el archivo
  rowCount = table.getRowCount();
  println(rowCount + " filas en la tabla");
  
  //segundo
  tiempo = new String [rowCount];
  
  //tercero
  suba = new int [rowCount];
  
  //cuarto
 kennedy = new int [rowCount];
  
  //quinto
  lasFerias = new int [rowCount];
  carvajal = new int [rowCount];
  
  titulo = loadFont("Montserrat-Medium-20.vlw");
  etiquetas = loadFont("Montserrat-Light-10.vlw");
  
  //segundo  
  for(int i = 0; i < rowCount; i++)
  {
    //creamos un objeto que guarda la información de las filas de la tabla
    TableRow row = table.getRow(i);
    
    //guardamos la información de la fila "tiempo" en un arreglo
    tiempo[i]= row.getString("tiempo");
    
    //tercero
    //guardamos la información de la fila "ComcelProveedorSuscripcion" en un arreglo
    suba[i]= row.getInt("Suba");
    
    //cuarto
    //guardamos la información de la fila "MovistarProveedorSuscripcion" en un arreglo
    kennedy[i]= row.getInt("Kennedy");
    
    //quinto
    lasFerias[i]= row.getInt("LasFerias");
    carvajal[i]= row.getInt("Carvajal");
        
      
    //tercero    
    //determina el valor max de todas las columnas
    
    datoSuba = suba[i];
    if (datoSuba > maxDato) 
    {
      maxDato = datoSuba;
    }
    
    //cuarto
    datoKennedy = kennedy[i];
    if (datoKennedy > maxDato) 
    {
      maxDato = datoKennedy;
    }
    
    
    //quinto
    datoLasFerias = lasFerias[i];
    if (datoLasFerias > maxDato) 
    {
      maxDato = datoLasFerias;
    }
       
    datoCarvajal = carvajal[i];
    if (datoCarvajal > maxDato) 
    {
      maxDato = datoCarvajal;
    }
    
  //segundo  
  }  
  
  
  //tercero
  println(maxDato + " es el valor maximo de todas las columnas");
  
  
    
}

void draw()
{
    textFont(titulo, 20);
    fill(0);
    text("Calidad del Aire en las 4 RMCAB más pobladas",25, 50);
    drawScatter();  
    dataInfo(#21243d, "Suba", 0, 0);
    dataInfo(#88e1f2, "Kennedy", 70, 65);
    dataInfo(#ff7c7c, "Las Ferias", 140, 135 );
    dataInfo(#ffd082, "Carvajal", 210, 205);

}

void dataInfo(int hexColor, String texto, int incremento, int incrementoTexto){
    println("Valor x elipse" + xElipse);
    fill(hexColor);
    ellipse(xElipse+incremento, 370, 10, 10);
    fill(0);
    textFont(etiquetas, 10);
    text(texto, xTexto+incrementoTexto, 375);
   
}

void drawScatter()
{
  textFont(titulo, 10);
  noStroke();
  
  //cuadro gris de contexto en donde se colocan los valores
  fill(100);
  rect(0, 70, 560, 242);
  
  //cuadro blanco en donde se coloca el digrama de curvas
  fill(255);
  rect(55, 80, 420, 220);
    
  
  //lineas veticales, cada linea es un dato del archivo que se dibujará en el espacio
  strokeWeight(1);
  stroke(0);
  
  //son 14 lineas verticales correspondiente a los 14 datos de cada columna de la tabla 
  for (int i = 0; i < rowCount; i++) // desde la 0 hasta la 13
  {
      //se replican las lineas 14 veces, en las pocisiones dentro del espacio del diagrama
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      line(x, 80, x, 300);
      
      //segundo
      //se coloca el texto en cada linea
      fill(0);
      //text(tiempo[i], x, 320);
      
      
      //segundo A
      pushMatrix();
      translate(x,320);
      rotate(PI/2);
      //se coloca el texto en cada linea
      text(tiempo[i], 0, 0);
      popMatrix();
   
  }
   
  //tercero
 
  //son las lineas horizonales correspondiente a el max dato dividido la cantidad de lineas que quiero ver   
  //13121911/8 = 1640238   91/5  18.2
  //2000000
  for (int i = 0; i < maxDato; i+=20) 
  {
      //se replican las lineas, en las pocisiones dentro del espacio del diagrama
      float y = map(i, 0, maxDato, 300, 80);
      line(55, y, 475, y);
      
      //texto con el valor de cada linea
      fill(255);
      //se coloca el texto en cada linea
      text(i, 0, y);
  }
    
 
   

  
  //quinto B
  //puntos Carvajal
  noStroke();
  fill(255, 208, 130);
  //recorre 14 veces
  for (int i = 0; i < rowCount; i++) //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      float y = map(carvajal[i], 0, maxDato, 300, 100);
      //ellipse(x,y,10,10);
      //rect(x, y,10,300-y); //alto - el punto y
      //println(i + "  " + Uff[i]  + "  " + x  + "  " + y);
  }

  //poligono Uff
  beginShape();
  for (int i = 0; i < rowCount; i++) 
  {
      float x = map(i, 0, rowCount-1, 55, 475);
      float y = map(carvajal[i], 0, maxDato, 300, 100);
      vertex(x, y); 
  }
  vertex(475, 300);
  vertex(55, 300);
  endShape(CLOSE); 
 
  
  //cuarto A
  // puntos MOVISTAR
  noStroke();
  fill(136, 225, 242);
  //recorre 14 veces
  for (int i = 0; i < rowCount; i++) //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      float y = map(kennedy[i], 0, maxDato, 300, 100);
      //ellipse(x, y, 10,10);
      //rect(x, y,10,300-y); //alto - el punto y
      //println(i + "  " + movistar[i]  + "  " + x  + "  " + y);
  } 
  
  //cuarto B
 
  //poligono MOVISTAR
  beginShape();
  for (int i = 0; i < rowCount; i++) //desde la 0 hasta la 13
  {
      float x = map(i , 0, rowCount-1, 55, 475);  //desde la 0 hasta la 13
      float y = map(kennedy[i], 0, maxDato, 300, 100);
      vertex(x, y); 
  }
  vertex(475, 300);
  vertex(55, 300);
  endShape(CLOSE);
  
  
  //tercero A
  //scatter de comcel
  noStroke();
  fill(33, 36, 61);
  
 
  //tercero B
  
  // puntos comcel
  //recorre 14 veces
  for (int i = 0; i < rowCount; i++)  //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      float y = map(suba[i], 0, maxDato, 300, 100);
      //ellipse(x, y,10,10); 
      //rect(x, y,10,300-y); //alto - el punto y
      //println(i + "  " + comcel[i]  + "  " + x  + "  " + y);
  }
  
  //tercero C
  
  //poligono comcel
  beginShape();
  for (int i = 0; i < rowCount; i++)  //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      float y = map(suba[i], 0, maxDato, 300, 100); 
      vertex(x, y); 
  }
  vertex(475, 300);
  vertex(55, 300);
  endShape(CLOSE);
  
    
  //quinto A
  // puntos TIGO
  noStroke();
  fill(255, 124, 124);
  //recorre 14 veces
  for (int i = 0; i < rowCount; i++) //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475); //desde la 0 hasta la 13
      float y = map(lasFerias[i], 0, maxDato, 300, 100);
      //ellipse(x, y, 10,10);
      //rect(x, y,10,300-y); //alto - el punto y
      //println(i + "  " + tigo[i]  + "  " + x  + "  " + y);
  }    
  
 //poligono Tigo
  beginShape();
  for (int i = 0; i < rowCount; i++) //desde la 0 hasta la 13
  {
      float x = map(i, 0, rowCount-1, 55, 475);   //desde la 0 hasta la 13
      float y = map(lasFerias[i], 0, maxDato, 300, 100);
      vertex(x, y); 
  }
  vertex(475, 300);
  vertex(55, 300);
  endShape(CLOSE);
 
  
  
  
}
