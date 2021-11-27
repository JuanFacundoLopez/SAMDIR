function personalizarBoton(jcomponent)
        jBorder = javax.swing.BorderFactory.createRaisedBevelBorder; 
        %jcomponent.setForeground(java.awt.Color.blue);
        jcomponent.setBackground(java.awt.Color.gray);
        jcomponent.setCursor(java.awt.Cursor(java.awt.Cursor.HAND_CURSOR));
        jcomponent.setContentAreaFilled(true);
        jcomponent.setBorder(jBorder);
        jcomponent.setOpaque(true);
end