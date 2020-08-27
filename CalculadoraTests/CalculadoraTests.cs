using System;
using Xunit;

namespace CalculadoraTests
{
    public class CalculadoraTests
    {
        [Fact]
        public void Calculadora_Soma_DeveRetornarSoma()
        {
            //Arrange
            var calculadora = new Calculadora.Calculadora();

            //Act
            var resultado = calculadora.Soma(5, 2);

            //Assert
            Assert.Equal(expected: 4, actual:resultado);
        }
    }
}
