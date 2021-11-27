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
public class botonGuardarCls {
    public static javax.swing.JButton guardar = new javax.swing.JButton();


    public static void setTrigger(String actionCommand) {
        guardar.setActionCommand(actionCommand);
        guardar.doClick();
    }

    public static javax.swing.JButton getTrigger() {
        return guardar;
    }

    public static String getTriggerActionString() {
        String action = guardar.getActionCommand();
        return action;
    }

    public static String getTriggerNameString() {
        String name = guardar.getName();
        return name;
    }

}
