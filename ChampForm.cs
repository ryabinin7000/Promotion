using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class ChampForm : Form
    {
        public DbController dbController;
        public ChampForm()
        {
            InitializeComponent();
        }

        private void UpdateChampsGrid()
        {
            champGridView.Rows.Clear();
            List<Champion> champs = new List<Champion>();
            try
            {
                champs = dbController.GetChamps();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о чемпионах. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Champion champ in champs)
            {
                champGridView.Rows.Add(champ.Code, champ.FIO, champ.Weight, champ.Date);
            }
        }

        private void buttonChampUpdate_Click(object sender, EventArgs e)
        {
            UpdateChampsGrid();
        }

        private void buttonChampExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void ChampForm_Load(object sender, EventArgs e)
        {
            UpdateChampsGrid();
        }
    }
}
