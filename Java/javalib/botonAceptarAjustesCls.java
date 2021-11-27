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
public class botonAceptarAjustesCls {
    public static javax.swing.JButton aceptarAjustes = new javax.swing.JButton();


    public static void setTrigger(String actionCommand) {
        aceptarAjustes.setActionCommand(actionCommand);
        aceptarAjustes.doClick();
    }

    public static javax.swing.JButton getTrigger() {
        System.out.println("Deberia devolver el boton");
        return aceptarAjustes;
    }

    public static String getTriggerActionString() {
        String action = aceptarAjustes.getActionCommand();
        return action;
    }

    public static String getTriggerNameString() {
        String name = aceptarAjustes.getName();
        return name;
    }
}
