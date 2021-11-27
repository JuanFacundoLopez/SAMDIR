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
public class botonVerFiltroCls {
    public static javax.swing.JButton verFiltro = new javax.swing.JButton();


    public static void setTrigger(String actionCommand) {
        verFiltro.setActionCommand(actionCommand);
        verFiltro.doClick();
    }

    public static javax.swing.JButton getTrigger() {
        return verFiltro;
    }

    public static String getTriggerActionString() {
        String action = verFiltro.getActionCommand();
        return action;
    }

    public static String getTriggerNameString() {
        String name = verFiltro.getName();
        return name;
    }
    
    public static void setEnable(){
        verFiltro.setEnabled(true);
    }
    
    public static void setDisable(){
        verFiltro.setEnabled(false);
    }
}
