/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

package samdir_gui;


import javax.swing.UIManager;

/**
 *
 * @author Administrador
 */
public class Main {

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        // TODO code application logic here
        //Configuracion con= new Configuracion();
        try 
        { 
            UIManager.setLookAndFeel("com.sun.java.swing.plaf.nimbus.NimbusLookAndFeel");
        } 
        catch(Exception e){ 
        }
        config con = new config();
        con.setVisible(true);
        //   funcionDeTransf ft = new funcionDeTransf();
    //  ft.setVisible(true);
     
    }

}
