using System;
using System.Collections.Generic;
using System.Windows.Forms;

namespace Promotion
{
    public partial class ContractForm : Form
    {
        public DbController dbController;
        public ContractForm()
        {
            InitializeComponent();
        }

        private void UpdateContractsGrid()
        {
            contractGridView.Rows.Clear();
            List<Contract> contracts = new List<Contract>();
            try
            {
                contracts = dbController.GetContracts();
            }
            catch (Exception e)
            {
                MessageBox.Show("Ошибка чтения данных о контрактах. Пожалуйста, проверьте подключение к серверу.\n" +
                    "Информация об ошибке: " + e.Message,
                    "Ошибка", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
            foreach (Contract contract in contracts)
            {
                contractGridView.Rows.Add(contract.Number, contract.Code, contract.FIO, contract.Seniority,
                    contract.Fights, contract.Fee, contract.Salary, contract.Compen, contract.Min,
                    contract.SignDate, contract.EndDate);
            }
        }

        private void buttonContractUpdate_Click(object sender, EventArgs e)
        {
            UpdateContractsGrid();
        }

        private void buttonContractExit_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void ContractForm_Load(object sender, EventArgs e)
        {
            UpdateContractsGrid();
        }
    }
}
