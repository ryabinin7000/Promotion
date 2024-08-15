using System;
using System.Windows.Forms;

namespace Promotion
{
    public partial class deleteForm : Form
    {
        public bool DeleteAllow;
        public deleteForm()
        {
            InitializeComponent();
            DeleteAllow = false;
        }

        private void buttonDelCancel_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void buttonDelYes_Click(object sender, EventArgs e)
        {
            DeleteAllow = true;
            Close();
        }

        private void buttonDelNo_Click(object sender, EventArgs e)
        {
            MessageBox.Show("Удаление строк отменено", "Удаление", MessageBoxButtons.OK,
                MessageBoxIcon.Information);
            Close();
        }
    }
}
