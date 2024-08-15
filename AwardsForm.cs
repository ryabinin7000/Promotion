using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class AwardsForm : Form
    {
        public DbController dbController;
        public AwardsForm()
        {
            InitializeComponent();
        }

        private void UpdateAwardsGrid()
        {
            awardsGridView.Rows.Clear();
            List<Award> awards = new List<Award>();
            try
            {
                awards = dbController.GetAwards();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о наградах. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Award award in awards)
            {
                awardsGridView.Rows.Add(award.Code, award.FIO1, award.FIO2, award.Event,
                    award.Date, award.AwardName, award.Awarded, award.Money);
            }
        }

        private void AwardsForm_Load(object sender, EventArgs e)
        {
            UpdateAwardsGrid();
        }

        private void buttonAwardUpdate_Click(object sender, EventArgs e)
        {
            UpdateAwardsGrid();
        }

        private void buttonAwardExit_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}
