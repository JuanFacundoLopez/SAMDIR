/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package samdir_gui;

/**
 *
 * @author Ana
 */
public class botonSalirCls {
    public static javax.swing.JButton salir = new javax.swing.JButton();


    public static void setTrigger(String actionCommand) {
        salir.setActionCommand(actionCommand);
        salir.doClick();
    }

    public static javax.swing.JButton getTrigger() {
        return salir;
    }

    public static String getTriggerActionString() {
        String action = salir.getActionCommand();
        return action;
    }

    public static String getTriggerNameString() {
        String name = salir.getName();
        return name;
    }
    
}
